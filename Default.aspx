<%@ Page Title="Inicio - Tractis demo" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="Tractis_demo._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Demostracion de autenticacion con dni usando Tractis
    </h2>
    <p>
        La aplicacion es una aplicacion muy simple de asp.net que utiliza los proveedores: <i>AspNetSqlMembershipProvider</i> y <i>AspNetSqlProfileProvider</i>
        para autenticar a los usuarios de forma estandar (usuario y contraseña) y guardar el Nif en el perfil del usuario para la autenticación con
        tractis.
    </p>
    <p>
        El codigo fuente esta disponible bajo licencia <a href="http://www.apache.org/licenses/LICENSE-2.0.html">Apache 2.0</a>
        en <a href="https://github.com/dmarzo/Tractis_aspnet_demo">https://github.com/dmarzo/Tractis_aspnet_demo</a>
        <p>
            Es necesario VS 2010 y SQL Server (Con su version express es suficiente).
            <br />
            Recordar cambiar en el web.config la clave <i>Tractis.api.key</i> con la clave obtenida en tractis.
        </p>
    </p>

</asp:Content>
