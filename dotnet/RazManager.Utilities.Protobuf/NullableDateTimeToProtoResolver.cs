using AutoMapper;
using System;


namespace RazManager.Utilities.Protobuf
{
    public class NullableDateTimeToProtoResolver : IMemberValueResolver<object, object, DateTime?, Google.Protobuf.WellKnownTypes.Timestamp>
    {
        public Google.Protobuf.WellKnownTypes.Timestamp Resolve(object source, object destination, DateTime? sourceMember, Google.Protobuf.WellKnownTypes.Timestamp destMember, ResolutionContext context)
        {
            if (!sourceMember.HasValue || sourceMember.Equals(DateTime.MinValue) || sourceMember.Equals(DateTime.MaxValue))
            {
                return new Google.Protobuf.WellKnownTypes.Timestamp();
            }
            return Google.Protobuf.WellKnownTypes.Timestamp.FromDateTime(sourceMember.Value);
        }
    }
}
