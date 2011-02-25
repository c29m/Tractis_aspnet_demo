<%@ Page Title="About Us" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Inicio.aspx.cs" Inherits="Tractis_demo.Privado.Inicio" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>Zona de usuarios</h2>
    <p>
        Informacion del usuario:     
    </p>
    <ul>
        <li>
            <label>Nif:</label>
            <%= Context.Profile.GetPropertyValue("Nif") %>
        </li>
    </ul>
</asp:Content>
