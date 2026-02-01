using AutoMapper;
using System;


namespace RazManager.Utilities.Protobuf
{
    public class NullableGuidFromProtoResolver : IMemberValueResolver<object, object, string, Guid?>
    {
        public Guid? Resolve(object source, object destination, string sourceMember, Guid? destMember, ResolutionContext context)
        {
            return string.IsNullOrEmpty(sourceMember) ? null : new Guid(sourceMember);
        }
    }
}
