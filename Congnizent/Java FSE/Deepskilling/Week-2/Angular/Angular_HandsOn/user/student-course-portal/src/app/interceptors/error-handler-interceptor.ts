import { inject } from '@angular/core';
import { HttpInterceptorFn, HttpErrorResponse } from '@angular/common/http';
import { Router } from '@angular/router';
import { catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';

export const errorHandlerInterceptor: HttpInterceptorFn = (req, next) => {
  const router = inject(Router);

  return next(req).pipe(
    catchError((error: HttpErrorResponse) => {
      console.error('Globally intercepted HTTP error:', error);
      if (error.status === 401) {
        console.warn('Unauthorized request! Redirecting to home.');
        router.navigate(['/']);
      } else if (error.status === 500) {
        alert('Global Server Error (500): Something went wrong on the server.');
      }
      return throwError(() => error);
    })
  );
};
