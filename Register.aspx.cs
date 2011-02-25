using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Profile;

namespace Tractis_demo
{
    public partial class Register : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            registerUser.ContinueDestinationPageUrl = Request.QueryString["ReturnUrl"];
        }

        protected void RegisterUser_CreatedUser(object sender, EventArgs e)
        {
            guardaInformacionPerfil();

            FormsAuthentication.SetAuthCookie(registerUser.UserName, false /* createPersistentCookie */);

            string continueUrl = registerUser.ContinueDestinationPageUrl;
            if (String.IsNullOrEmpty(continueUrl))
            {
                continueUrl = "~/";
            }
            Response.Redirect(continueUrl);
        }

        private void guardaInformacionPerfil()
        {
            //Crear un perfil vacio para el usuario recien creado
            ProfileBase profile = ProfileBase.Create(registerUser.UserName, true);

            //Actualizar el perfil
            profile.SetPropertyValue("Nif",((TextBox)registerUserWizardStep.ContentTemplateContainer.FindControl("Nif")).Text.Trim());
            //TOHACK hacer unico el campo NIF

            profile.Save();
        }

    }
}
