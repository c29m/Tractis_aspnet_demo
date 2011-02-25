<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Tractis_demo.Tractis.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="text-align:center">
    <form action="https://www.tractis.com/verifications" method="post" id="formulario">
		<input type="hidden" value="<%$ appSettings:Tractis.api.key %>" runat="server" name="api_key" id="api_key" />
		<input type="hidden" value="<%= this.CallbackURL() %>" name="notification_callback" />
        <input type="hidden" value="true" name="public_verification"/>
		<input type="submit" name="commit" value="Iniciar sesión" class="boton" id="buttonSubmit" />
        <p>
            Conectando con tractis...
        </p>
	 </form>
     <script language="JavaScript" type="text/javascript">
     <!--
         document.getElementById('buttonSubmit').style.display = 'none';
         document.forms[0].submit();
      //-->
     </script>
</body>
</html>
