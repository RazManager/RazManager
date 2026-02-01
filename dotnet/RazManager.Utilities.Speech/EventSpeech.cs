using Microsoft.CognitiveServices.Speech;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Linq;


namespace RazManager.Utilities.Speech
{
    public enum SpeechStyle
    {
        Normal,
        Faster,
        Fastest,
        PositionLeader,
        PositionGained,
        PositionLost,
        GapAfter,
        GapBefore,
        BadLap
    }

    public class EventSpeech : IEventSpeech
    {
        private readonly SpeechConfigOptions _speechConfigOptions;

        public EventSpeech(SpeechConfigOptions speechConfigOptions)
        {
            _speechConfigOptions = speechConfigOptions;
        }


        public async Task<IEnumerable<(string locale, string localeName, string localName)>> GetSettingsAsync(string locale)
        {
            var speechConfig = SpeechConfig.FromEndpoint(_speechConfigOptions.SpeechConfigEndpoint, _speechConfigOptions.SpeechConfigKey);
            using (var speechSynthesizer = new SpeechSynthesizer(speechConfig, null))
            {
                using (var result = await speechSynthesizer.GetVoicesAsync())
                {
                    return result.Voices
                        .Where(x => x.Locale == locale && !x.Locale.StartsWith("en") || x.Locale.StartsWith("en") && x.StyleList.Any(s => s.Contains("shouting")))
                        .OrderBy(x => x.Locale)
                        .ThenBy(x => x.LocalName)
                        .Select(x => (x.Locale, CultureInfo.GetCultureInfo(x.Locale).EnglishName, x.LocalName));
                }
            }
        }


        public async Task<string?> GetNameAsync(string locale, string localName)
        {
            var speechConfig = SpeechConfig.FromEndpoint(_speechConfigOptions.SpeechConfigEndpoint, _speechConfigOptions.SpeechConfigKey);
            using (var speechSynthesizer = new SpeechSynthesizer(speechConfig, null))
            {
                using (var result = await speechSynthesizer.GetVoicesAsync(locale))
                {
                    return result.Voices.SingleOrDefault(x => x.LocalName == localName)?.Name;
                }
            }
        }


        public async Task<byte[]?> SpeekAsync(string locale, string name, string text, SpeechStyle speechStyle)
        {
            if (locale.Contains("en"))
            {
                text = text.Replace(".", " point ");
            }

            string style;
            string[] styles;
            switch (speechStyle)
            {
                case SpeechStyle.Faster:
                case SpeechStyle.PositionGained:
                    styles = ["cheerful", "excited"];
                    style = styles[new Random().Next(styles.Length)];
                    break;

                case SpeechStyle.Fastest:
                case SpeechStyle.PositionLeader:
                    styles = ["shouting"];
                    style = styles[new Random().Next(styles.Length)];
                    break;

                case SpeechStyle.PositionLost:
                    styles = ["angry", "terrified", "unfriendly"];
                    style = styles[new Random().Next(styles.Length)];
                    break;

                case SpeechStyle.BadLap:
                    styles = ["sad"];
                    style = styles[new Random().Next(styles.Length)];
                    break;

                default:
                    styles = ["chat", "friendly", "hopeful"];
                    style = styles[new Random().Next(styles.Length)];
                    break;
            }

            var namespaceMstts = XNamespace.Get("https://www.w3.org/2001/mstts");
            var xml = new XDocument(
                new XElement("speak", new XAttribute("version", "1.0"),
                    new XAttribute(XNamespace.None + "xlmns", "http://www.w3.org/2001/10/synthesis"),
                    new XAttribute(XNamespace.Xmlns + "mstts", namespaceMstts.ToString()),
                    new XAttribute(XNamespace.Xml + "lang", locale),
                        new XElement("voice", new XAttribute("name", name),
                            new XElement(namespaceMstts + "express-as", new XAttribute("style", style), text)
                ))
            );

            var speechConfig = SpeechConfig.FromEndpoint(_speechConfigOptions.SpeechConfigEndpoint, _speechConfigOptions.SpeechConfigKey);
            using (var speechSynthesizer = new SpeechSynthesizer(speechConfig, null))
            {
                var speechSynthesisResult = await speechSynthesizer.SpeakSsmlAsync(xml.ToString());
                if (speechSynthesisResult.Reason == ResultReason.SynthesizingAudioCompleted)
                {
                    return speechSynthesisResult.AudioData;
                }
            }

            return null;
        }
    }
}
