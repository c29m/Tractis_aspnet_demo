<%@ Page Language="C#" %>
<script language="C#" runat="server">
    protected String GetApiKey() 
    {
        return System.Configuration.ConfigurationManager.AppSettings["Tractis.api.key"];
    }

    protected Uri CallbackURL()
    {
        Uri url = Request.Url;
        return new Uri(url.Scheme + "://" + url.Authority + ResolveUrl("~/Tractis_callback.aspx"));
    }
    
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Demo autenticación con tractis</title>
</head>
<body>
        <h1>Demo autenticación con tractis</h1>
        <form action="https://www.tractis.com/verifications" method="post" id="formulario">
		    <input type="hidden" value="<%= this.GetApiKey()%>" name="api_key" />
		    <input type="hidden" value="<%= this.CallbackURL() %>" name="notification_callback" />
            <!-- OPCIONAL: el campo public_verification es opcional -->
            <input type="hidden" value="true" name="public_verification"/>

		    <input type="submit" name="commit" value="Iniciar sesión" class="boton" id="buttonSubmit" />
        </form>
        <p>
            <a href="https://www.tractis.com/help/?p=3537&language=es">¿Cómo se integran las Verificaciones de Identidad? (How-To)</a>
        </p>
</body>
</html>
