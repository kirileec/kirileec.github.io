title: RestSharp use Newtonsoft.JSON to serialize object and deserialize json
date: "2016-12-21 23:04:20"
update: ""
author: me
tags:
- CSharp-WPF
categories:
- CSharp-WPF
topic: ""
cover: ""
draft: false
preview: ""
top: false
type: ""
hide: false
toc: false
image: ""
subtitle: ""
config: {}


---



```c#
    public class SaturnJsonSerializer : ISerializer
    {
        private readonly JsonSerializer _serializer;

        public SaturnJsonSerializer()
        {
            ContentType = "application/json";
            _serializer = new JsonSerializer
            {
                MissingMemberHandling = MissingMemberHandling.Ignore,
                NullValueHandling = NullValueHandling.Include,
                DefaultValueHandling = DefaultValueHandling.Include
            };
        }

        public SaturnJsonSerializer(JsonSerializer serializer)
        {
            ContentType = "application/json";
            _serializer = serializer;
        }

        public string Serialize(object obj)
        {
            using (var stringWriter = new StringWriter())
            {
                using (var jsonTextWriter = new JsonTextWriter(stringWriter))
                {
                    jsonTextWriter.Formatting = Formatting.Indented;
                    jsonTextWriter.QuoteChar = '"';

                    _serializer.Serialize(jsonTextWriter, obj);

                    var result = stringWriter.ToString();
                    return result;
                }
            }
        }

        public string DateFormat { get; set; }

        public string RootElement { get; set; }

        public string Namespace { get; set; }

        public string ContentType { get; set; }
    }
```
```c#
public class SaturnRequest : RestRequest
    {
        #region Constructors
        public SaturnRequest()
        {
            IntializeJsonSerializer();
        }

        public SaturnRequest(Method method) : base(method)
        {
            IntializeJsonSerializer();
        }

        public SaturnRequest(string resource) : base(resource)
        {
            IntializeJsonSerializer();
        }

        public SaturnRequest(string resource, Method method) : base(resource, method)
        {
            IntializeJsonSerializer();
        }

        public SaturnRequest(Uri resource) : base(resource)
        {
            IntializeJsonSerializer();
        }

        public SaturnRequest(Uri resource, Method method) : base(resource, method)
        {
            IntializeJsonSerializer();
        }

        #endregion

        #region Methods
        protected void IntializeJsonSerializer()
        {
            JsonSerializer = new SaturnJsonSerializer();
        }
        #endregion
    }
```
##usage

```c#
var request = new SaturnRequest("/api",Method.POST);
request.AddJsonBody(obj);
```
