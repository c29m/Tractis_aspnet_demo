using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Tractis_demo.Tractis
{
    public partial class Login : System.Web.UI.Page
    {
        public const string TRACTIS_RETURN_URL = "Tractis_ReturnUrl";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session[TRACTIS_RETURN_URL] = ReturnURL();
            }
        }

        protected Uri CallbackURL() 
        {
            Uri url = Request.Url;
            return new Uri(url.Scheme + "://" + url.Authority + ResolveUrl("~/Tractis/Callback.aspx"));
        }

        private Uri ReturnURL() 
        {
             Uri returnURL = null;
             try{
                    String rawReturnURL = (Request["ReturnUrl"] + "").Trim();
                    if (rawReturnURL != "")
                    {
                        Uri baseUrl = new Uri(Request.Url.Scheme + "://" + Request.Url.Authority);
                        returnURL = new Uri(baseUrl, rawReturnURL);
                    }
            }
            catch
            {
            }
            return returnURL;
        }

    }
}