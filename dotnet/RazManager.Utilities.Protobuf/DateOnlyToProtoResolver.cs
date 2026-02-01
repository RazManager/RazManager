using AutoMapper;
using System;


namespace RazManager.Utilities.Protobuf
{
    public class DateOnlyToProtoResolver : IMemberValueResolver<object, object, DateOnly, Google.Protobuf.WellKnownTypes.Timestamp>
    {
        public Google.Protobuf.WellKnownTypes.Timestamp Resolve(object source, object destination, DateOnly sourceMember, Google.Protobuf.WellKnownTypes.Timestamp destMember, ResolutionContext context)
        {
            return Google.Protobuf.WellKnownTypes.Timestamp.FromDateTime(sourceMember.ToDateTime(TimeOnly.MinValue, DateTimeKind.Utc));
        }
    }
}
