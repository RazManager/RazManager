using AutoMapper;
using System;


namespace RazManager.Utilities.Protobuf
{
    public class NullableTimeSpanToProtoResolver : IMemberValueResolver<object, object, TimeSpan?, Google.Protobuf.WellKnownTypes.Duration>
    {
        public Google.Protobuf.WellKnownTypes.Duration Resolve(object source, object destination, TimeSpan? sourceMember, Google.Protobuf.WellKnownTypes.Duration destMember, ResolutionContext context)
        {
            if (!sourceMember.HasValue)
            {
                return new Google.Protobuf.WellKnownTypes.Duration();
            }
            return Google.Protobuf.WellKnownTypes.Duration.FromTimeSpan(sourceMember.Value);
        }
    }
}
