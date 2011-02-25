<%@ Page Language="C#" %>

<script language="C#" runat="server">
    
    protected String Dni { get { return (Request["tractis:attribute:dni"] + "").Trim(); } }

    protected override void OnLoad(EventArgs e)
    {
        //Pagina llamada una vez a seleccionado el certificado en tractis
        //Como parametros de la url recibiremos los datos extraidos del certificado (numero de dni, nombre, apellidos, etc..)
        //Hay que comprobar, llamando a tractis que la informacion que recibimos es valida
        if (CheckValidezAutenticacionEnTractis() == false)
        {
            mvResult.SetActiveView(vErrorVerificacion);
            lnkTractisVerificationURL.HRef = Request["verification_url"] + "";
            lnkTractisVerificationURL.Visible = (lnkTractisVerificationURL.HRef != "");
        }
        else
        {
            //TODO  Iniciar sesion segun el dni del usuario
            String[] validsDNIs = new String[]{"12345678A","72697564S"}; 
        
           if (validsDNIs.Contains(Dni) == false)
            {
                mvResult.SetActiveView(vErrorNoUser);
                lblNoUserDni.Text = Dni;
            }
            else
            {
                mvResult.SetActiveView(vOk);
                lblOkNif.Text = Dni;
            }
        }
    }

    private bool CheckValidezAutenticacionEnTractis()
    {
        //Enviar mediante post los parametros recibidos añadiendo el api_key
        NameValueCollection requestParams = new NameValueCollection(Request.QueryString);
        requestParams["api_key"] = ConfigurationManager.AppSettings["Tractis.api.key"];
        byte[] postData = Encoding.ASCII.GetBytes(ConstructQueryString(requestParams));

        System.Net.HttpWebRequest request = (System.Net.HttpWebRequest)System.Net.WebRequest.Create(new Uri("https://www.tractis.com/data_verification"));
        request.Method = "POST";
        request.ContentType = "application/x-www-form-urlencoded";
        request.ContentLength = postData.Length;
        request.Timeout = (int)TimeSpan.FromSeconds(20).TotalMilliseconds;
        using (System.IO.Stream requestStream = request.GetRequestStream())
        {
            requestStream.Write(postData, 0, postData.Length);
        }

        //Leer la respueta, si todo a ido ok, respondera con el codigo 200
        bool result = false;
        try
        {
            using (System.Net.HttpWebResponse response = (System.Net.HttpWebResponse)request.GetResponse())
            {
                result = (response.StatusCode == System.Net.HttpStatusCode.OK);
            }
        }
        catch
        {
            result = false;
        }
        return result;
    }

    public static String ConstructQueryString(NameValueCollection parameters)
    {
        System.Collections.Generic.List<String> items = new System.Collections.Generic.List<String>(parameters.Count);

        foreach (String name in parameters.Keys)
        {
            if ((name != null) && (name.Trim() != ""))
            {
                items.Add(String.Concat(name, "=", System.Web.HttpUtility.UrlEncode(parameters[name])));
            }
        }

        return String.Join("&", items.ToArray());
    }

    
</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <div id="mainPanel">
        <h1>Resultado de la autenticación</h1>
        <asp:MultiView runat="server" ID="mvResult">
            <asp:View runat="server" ID="vErrorVerificacion">
                Ha ocurrido un error al verificar su certificado en tractis.
                <a runat="server" id="lnkTractisVerificationURL">URL de verificacíon</a>
                <p>
                    Por favor vuelva a intenar iniciar sesión, en unos instantes.
                </p>
            </asp:View> 
            <asp:View runat="server" ID="vErrorNoUser">
                No se ha encontrado ningun usuario con el dni: <asp:Label ID="lblNoUserDni" runat="server" />
                <p>
                    Por favor vuelva a intenar iniciar sesión con el certificado de un usuario registrado.
                </p>
            </asp:View>
            <asp:View runat="server" ID="vUserNoValid">
                El usuario <asp:Label ID="lblUserNoValidUserName" runat="server" Font-Italic="true" /> no es valido: esta bloqueado, a falta de aprovación
                o no existe.
                <p>
                    Por favor vuelva a intenar iniciar sesión con el certificado de un usuario valido.
                </p>
            </asp:View>
            <asp:View runat="server" ID="vOk">
                Autenticado con exito, usuario con nif <asp:Label ID="lblOkNif" runat="server" /> 
            </asp:View>
        </asp:MultiView>
    </div>
</body>
</html>
