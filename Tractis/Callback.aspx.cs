using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Text;
using System.Collections.Specialized;
using System.Configuration;
using System.IO;
using System.Web.Profile;
using System.Web.Security;

namespace Tractis_demo.Tractis
{
    public partial class Callback : System.Web.UI.Page
    {
        protected String Dni { get { return (Request["tractis:attribute:dni"] + "").Trim() ; } }


        protected void Page_Load(object sender, EventArgs e)
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
                
                //Buscar en los perfiles un dni y nombre
                //TOHACK realizar una consulta especifica a la base de datos
                ProfileInfo profile = ProfileManager.GetAllProfiles(ProfileAuthenticationOption.Authenticated).Cast<ProfileInfo>()
                    .Where(x => (ProfileBase.Create(x.UserName).GetPropertyValue("Nif") + "").Equals(Dni, StringComparison.InvariantCultureIgnoreCase))
                    .SingleOrDefault();

                if (profile == null) 
                {
                    mvResult.SetActiveView(vErrorNoUser);
                    lblNoUserDni.Text = Dni;  
                }
                else
                {
                    //Iniciar sesion
                    var user = Membership.GetUser(profile.UserName);
                    if ((user == null) || (user.IsApproved == false) || (user.IsLockedOut))
                    {
                        mvResult.SetActiveView(vUserNoValid);
                        lblUserNoValidUserName.Text = profile.UserName;
                    }
                    else
                    {
                        Uri returnURL = (Uri)Session[Login.TRACTIS_RETURN_URL];
                        Session[Login.TRACTIS_RETURN_URL] = null;
                        if (returnURL == null)
                        {
                            Uri baseUrl = new Uri(Request.Url.Scheme + "://" + Request.Url.Authority);
                            returnURL = new Uri(baseUrl,ResolveUrl("~"));
                        }

                        FormsAuthentication.SetAuthCookie(user.UserName, false);//No recordar al usuario, obliga a que tenga siempre el certificado (dni) al al iniciar sesion
                        mvResult.SetActiveView(vOk);
                        lnkOkIrA.HRef = returnURL.ToString();
                    }   
                }
            }
        }


        private bool CheckValidezAutenticacionEnTractis()
        {
            //Enviar mediante post los parametros recibidos añadiendo el api_key
            NameValueCollection requestParams = new NameValueCollection(Request.QueryString);
            requestParams["api_key"] = ConfigurationManager.AppSettings["Tractis.api.key"];
            byte[] postData = Encoding.ASCII.GetBytes(ConstructQueryString(requestParams));

            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(new Uri("https://www.tractis.com/data_verification"));
            request.Method = "POST";
            request.ContentType = "application/x-www-form-urlencoded";
            request.ContentLength = postData.Length;
            request.Timeout = (int)TimeSpan.FromSeconds(20).TotalMilliseconds;
            using (Stream requestStream = request.GetRequestStream())
            {
                requestStream.Write(postData, 0, postData.Length);
            }
          
            //Leer la respueta, si todo a ido ok, respondera con el codigo 200
            bool result = false;
            try
            {
                using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
                {
                    result = (response.StatusCode == HttpStatusCode.OK);
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
            List<String> items = new List<String>(parameters.Count);

            foreach (String name in parameters.Keys)
            {
                if ((name != null) && (String.IsNullOrWhiteSpace(name) == false))
                {
                    items.Add(String.Concat(name, "=", System.Web.HttpUtility.UrlEncode(parameters[name])));
                }
            }

            return String.Join("&", items.ToArray());
        }

    }
}