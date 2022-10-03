using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;

/// <summary>
/// Descripción breve de BasePage
/// </summary>
public class BasePage : System.Web.UI.Page
{
    protected override void InitializeCulture()
    {
        string culture = string.Empty;
        //verificamos el parametro en Request para verificar si ha espeficiado un valor
        //desde la URL
        if (!string.IsNullOrEmpty(Request["lang"]))
        {//se obtiene el valor del parametro.
            string lang = Request["lang"].ToLower();
            //salvamos en Session el valor del parametro recibido
            Session["lang"] = lang;
            //se verifica que cultura se debe de utilizar de acuerdo al valor.
            switch (lang)
            {
                case "en":
                    culture = "en-US";
                    break;
                case "es":
                    culture = "es-MX";
                    break;
                default:
                    culture = "es-MX";
                    break;
            }
        }
        else
        {

            if (!string.IsNullOrEmpty(Convert.ToString(Session["lang"])))
            {
                string lang = Session["lang"].ToString();
                switch (lang)
                {
                    case "en":
                        culture = "en-US";
                        break;
                    case "es":
                        culture = "es-MX";
                        break;
                    default:
                        culture = "es-MX";
                        break;
                }

            }
            else
            {
                culture = "es-MX";
                Session["lang"]= "es";
            }
        }
        //creamos y modificamos la especificacion de cultura a nuestra pagina.
        Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(culture);
        Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);
        base.InitializeCulture();
    }
}