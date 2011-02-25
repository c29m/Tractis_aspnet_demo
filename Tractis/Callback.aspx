<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Callback.aspx.cs" Inherits="Tractis_demo.Tractis.Callback" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <div id="mainPanel">
        <h1>Resultado de la autenticación</h1>
        <asp:MultiView runat="server" ID="mvResult">
            <asp:View runat="server" ID="vErrorVerificacion">
                Ha ocurrido un error al verificar su certificado en tractis.
                <a runat="server" id="lnkTractisVerificationURL">URL de verificacíon</a>
            </asp:View> 
            <asp:View runat="server" ID="vErrorNoUser">
                No se ha encontrado ningun usuario con el dni: <asp:Label ID="lblNoUserDni" runat="server" />
            </asp:View>
            <asp:View runat="server" ID="vUserNoValid">
                El usuario <asp:Label ID="lblUserNoValidUserName" runat="server" Font-Italic="true" /> no es valido: esta bloqueado, a falta de aprovación
                o no existe.
            </asp:View>
            <asp:View runat="server" ID="vOk">
                Autenticado con exito, <a runat="server" id="lnkOkIrA">Ir a la página solicitada</a>
                <script language="JavaScript" type="text/javascript">
                 <!--
                    document.getElementById('mainPanel').style.display = 'none';
                    var returnURL = document.getElementById('<%= lnkOkIrA.ClientID %>').href;
                    parent.change_parent_url(returnURL);        
                  //-->
                 </script>
            </asp:View>
        </asp:MultiView>
        <p>
            Por favor vuelva a intenar <a href="~/Login.aspx" runat="server" onclick="parent.change_parent_url(this.href)">iniciar sesión</a>, en unos instantes.
        </p>
    </div>
</body>
</html>
