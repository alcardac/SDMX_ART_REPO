﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ServiceModel;
using ISTATRegistry.MyService;

namespace ISTATRegistry
{
    public class WSClient
    {
        private Service1SoapClient _client;

        public WSClient(string endPointAddress)
        {
            BasicHttpBinding binding = new BasicHttpBinding();
            EndpointAddress address = new EndpointAddress(endPointAddress);
            _client = new Service1SoapClient(binding, address);
        }

        public Service1SoapClient GetClient()
        {
            return _client;
        }
    }
}