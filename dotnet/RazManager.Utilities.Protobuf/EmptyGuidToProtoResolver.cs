using AutoMapper;
using System;


namespace RazManager.Utilities.Protobuf
{
    public class EmptyGuidToProtoResolver : IMemberValueResolver<object, object, Guid, string>
    {
        public string Resolve(object source, object destination, Guid sourceMember, string destMember, ResolutionContext context)
        {
            return sourceMember.Equals(Guid.Empty) ? null! : sourceMember.ToString();
        }
    }
}
