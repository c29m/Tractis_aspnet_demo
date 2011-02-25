<%@ Page Title="Inicio de sesión" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Login.aspx.cs" Inherits="Tractis_demo.Account.Login" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Inicio de sesión
    </h2>
    <asp:MultiView ID="mvLogin" runat="server">
        <asp:View ID="vSelectMode" runat="server">
    <p>
        Si todavia no tienes cuenta,  <asp:HyperLink ID="registerHyperLink" runat="server" EnableViewState="false">registrate</asp:HyperLink>,
        para acceder a la zona privada.
    </p>
    <asp:Login ID="LoginUser" runat="server" EnableViewState="false" RenderOuterTable="false">
        <LayoutTemplate>
            <span class="failureNotification">
                <asp:Literal ID="FailureText" runat="server"></asp:Literal>
            </span>
            <asp:ValidationSummary ID="LoginUserValidationSummary" runat="server" CssClass="failureNotification" 
                 ValidationGroup="LoginUserValidationGroup"/>
            <div class="accountInfo" style="float:left" runat="server">
                <fieldset class="login">
                    <legend>Usuario/contraseña</legend>
                    <p>
                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">Nombre usuario:</asp:Label>
                        <asp:TextBox ID="UserName" runat="server" CssClass="textEntry"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" 
                             CssClass="failureNotification" ErrorMessage="El nombre de usuario es obligatorio." ToolTip="El nombre de usuario es obligatorio." 
                             ValidationGroup="LoginUserValidationGroup">*</asp:RequiredFieldValidator>
                    </p>
                    <p>
                        <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Contraseña:</asp:Label>
                        <asp:TextBox ID="Password" runat="server" CssClass="passwordEntry" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" 
                             CssClass="failureNotification" ErrorMessage="La contraseña es obligatoria." ToolTip="La contraseña es obligatoria." 
                             ValidationGroup="LoginUserValidationGroup">*</asp:RequiredFieldValidator>
                    </p>
                    <p>
                        <asp:CheckBox ID="RememberMe" runat="server"/>
                        <asp:Label ID="RememberMeLabel" runat="server" AssociatedControlID="RememberMe" CssClass="inline">recuerdame</asp:Label>
                    </p>
                     <p class="submitButton">
                        <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="Iniciar sesión" ValidationGroup="LoginUserValidationGroup"/>
                    </p>
                </fieldset>
            </div>
            <div class="accountInfo" style="float:left;margin-left:16px;" runat="server">
                <fieldset class="login">
                    <legend>Dni-e (Tractis)</legend>
                       <asp:Panel runat="server" >
                           <p>
                                <a href="?mode=tractis&ReturnUrl=<%= Request["ReturnUrl"] %>">Autenticarte usando DNI-e</a>
                           </p>
                       </asp:Panel>
                </fieldset>
            </div>
        </LayoutTemplate>
    </asp:Login>
    </asp:View>
        <asp:View ID="vModeTractis" runat="server">
            <iframe src="Tractis/Login.aspx?ReturnUrl=<%= Request["ReturnUrl"] %>" frameborder="0" scrolling="no" marginheight="0" height="560px" width="100%">
                    <p>Su navegador no soporta iframes</p>
            </iframe>
            <script type="text/javascript">
                 function change_parent_url(url) {
                     document.location = url;
                 }		
            </script>
        </asp:View>
    </asp:MultiView>
</asp:Content>

