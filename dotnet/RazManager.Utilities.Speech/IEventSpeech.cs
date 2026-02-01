using System.Collections.Generic;
using System.Threading.Tasks;

namespace RazManager.Utilities.Speech
{
    public interface IEventSpeech
    {
        Task<IEnumerable<(string locale, string localeName, string localName)>> GetSettingsAsync(string locale);
        Task<string?> GetNameAsync(string locale, string localName);
        Task<byte[]?> SpeekAsync(string locale, string name, string text, SpeechStyle speechStyle);
    }
}