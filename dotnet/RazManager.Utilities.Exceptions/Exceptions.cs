using System;


namespace RazManager.Utilities.Exceptions
{
    public class NotFoundException : ApplicationException
    {
        public NotFoundException() : base(ExceptionMessages.NotFound) { }
    }


    public class UpdateConflictException : ApplicationException
    {
        public UpdateConflictException() : base(ExceptionMessages.UpdateConflict) { }
        public UpdateConflictException(string message) : base(message) { }
    }


    public class DeleteConflictException : ApplicationException
    {
        public DeleteConflictException() : base(ExceptionMessages.DeleteConflict) { }
        public DeleteConflictException(string message) : base(message) { }
    }


    public class InternalException : ApplicationException
    {
        public InternalException() : base(ExceptionMessages.InternalError) { }
    }
}
