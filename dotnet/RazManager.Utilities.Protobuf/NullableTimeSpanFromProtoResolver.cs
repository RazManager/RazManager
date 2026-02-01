using AutoMapper;
using System;


namespace RazManager.Utilities.Protobuf
{
    public class NullableTimeSpanFromProtoResolver : IMemberValueResolver<object, object, Google.Protobuf.WellKnownTypes.Duration, TimeSpan?>
    {
        public TimeSpan? Resolve(object source, object destination, Google.Protobuf.WellKnownTypes.Duration sourceMember, TimeSpan? destMember, ResolutionContext context)
        {
            if (sourceMember is null ||
                sourceMember.Seconds == 0)
            {
                return null;
            }
            return sourceMember.ToTimeSpan();
        }
    }
}
