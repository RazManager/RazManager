using AutoMapper;
using System;


namespace RazManager.Utilities.Protobuf
{
    public class DateTimeFromProtoResolver : IMemberValueResolver<object, object, Google.Protobuf.WellKnownTypes.Timestamp, DateTime>
    {
        public DateTime Resolve(object source, object destination, Google.Protobuf.WellKnownTypes.Timestamp sourceMember, DateTime destMember, ResolutionContext context)
        {
            return sourceMember.ToDateTime();
        }
    }
}
