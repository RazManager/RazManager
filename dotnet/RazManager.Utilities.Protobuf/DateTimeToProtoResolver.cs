using AutoMapper;
using System;


namespace RazManager.Utilities.Protobuf
{
    public class DateTimeToProtoResolver : IMemberValueResolver<object, object, DateTime, Google.Protobuf.WellKnownTypes.Timestamp>
    {
        public Google.Protobuf.WellKnownTypes.Timestamp Resolve(object source, object destination, DateTime sourceMember, Google.Protobuf.WellKnownTypes.Timestamp destMember, ResolutionContext context)
        {
            return Google.Protobuf.WellKnownTypes.Timestamp.FromDateTime(sourceMember);
        }
    }
}
