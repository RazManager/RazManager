using AutoMapper;
using System;


namespace RazManager.Utilities.Protobuf
{
    public class NullableDateTimeFromProtoResolver : IMemberValueResolver<object, object, Google.Protobuf.WellKnownTypes.Timestamp, DateTime?>
    {
        public DateTime? Resolve(object source, object destination, Google.Protobuf.WellKnownTypes.Timestamp sourceMember, DateTime? destMember, ResolutionContext context)
        {
            if (sourceMember is null ||
                sourceMember.ToDateTime().Equals(DateTime.MinValue) ||
                sourceMember.ToDateTime().Equals(DateTime.MaxValue) ||
                sourceMember.Seconds == 0)
            {
                return null;
            }
            return sourceMember.ToDateTime();
        }
    }
}
