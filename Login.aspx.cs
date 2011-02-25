using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Tractis_demo.Account
{
    public partial class Login : System.Web.UI.Page
    {
        protected bool IsModeTractis { get { return (Request["mode"] + "").Equals("tractis", StringComparison.InvariantCultureIgnoreCase); } }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsModeTractis)
            {
                mvLogin.SetActiveView(vModeTractis);
            }
            else 
            {
                mvLogin.SetActiveView(vSelectMode);
                registerHyperLink.NavigateUrl = "Register.aspx?ReturnUrl=" + HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);
            }
            
           
        }
    }
}
