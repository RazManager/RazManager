using Grpc.Core;
using Grpc.Core.Interceptors;
using Microsoft.Extensions.Logging;
using RazManager.Utilities.Exceptions;
using System;
using System.ComponentModel.DataAnnotations;
using System.Threading.Tasks;


namespace RazManager.Utilities.Grpc
{
    public class GrpcServerInterceptor : Interceptor
    {
        private readonly ILogger<GrpcServerInterceptor> _logger;


        public GrpcServerInterceptor(ILogger<GrpcServerInterceptor> logger)
        {
            _logger = logger;
        }


        public override async Task<TResponse> UnaryServerHandler<TRequest, TResponse>(TRequest request, ServerCallContext context, UnaryServerMethod<TRequest, TResponse> continuation)
        {
            try
            {
                return await continuation(request, context);
            }
            catch (NotFoundException exception)
            {
                _logger.LogError(exception, exception.Message);
                throw new RpcException(new Status(StatusCode.NotFound, exception.Message));
            }
            catch (ValidationException exception)
            {
                _logger.LogError(exception, exception.Message);
                throw new RpcException(new Status(StatusCode.InvalidArgument, exception.Message));
            }
            catch (UpdateConflictException exception)
            {
                _logger.LogError(exception, exception.Message);
                throw new RpcException(new Status(StatusCode.FailedPrecondition, exception.Message));
            }
            catch (DeleteConflictException exception)
            {
                _logger.LogError(exception, exception.Message);
                throw new RpcException(new Status(StatusCode.FailedPrecondition, exception.Message));
            }
            catch (InternalException exception)
            {
                _logger.LogError(exception, exception.Message);
                throw new RpcException(new Status(StatusCode.Internal, exception.Message));
            }
            catch (Exception exception)
            {
                _logger.LogError(exception, exception.Message);
                throw;
            }
        }
    }
}
