﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using Newtonsoft.Json;

namespace Html5_Storage
{
    /// <summary>
    /// Summary description for DbHandler
    /// </summary>
    public class DbHandler : IHttpHandler
    {
        /// <summary>
        /// Json Çıktısı Olarak AppData İçindeki İlleri Servisten Yayınlıyoruz
        /// </summary>
        /// <param name="context"></param>
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "application/json";

            Dictionary<int,string> iller = new Dictionary<int, string>();

            using (StreamReader stramreader = new StreamReader(context.Server.MapPath("App_Data\\veri.txt")))
            {
                while (stramreader.Peek()>=0)
                {
                    try
                    {
                        string[] satir = stramreader.ReadLine().ToString().Split('	');
                        iller.Add(int.Parse(satir[0].Trim()), satir[1]);
                    }
                    catch (Exception)
                    {
                        
                    }
                }
                
            }

            context.Response.Write(JsonConvert.SerializeObject(iller.ToList()));

        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}