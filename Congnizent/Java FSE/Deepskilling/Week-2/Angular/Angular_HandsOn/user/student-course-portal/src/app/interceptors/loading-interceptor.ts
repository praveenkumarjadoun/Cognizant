import { inject } from '@angular/core';
import { HttpInterceptorFn } from '@angular/common/http';
import { LoadingService } from '../services/loading';
import { finalize } from 'rxjs/operators';

export const loadingInterceptor: HttpInterceptorFn = (req, next) => {
  const loadingService = inject(LoadingService);
  
  loadingService.show();
  
  return next(req).pipe(
    finalize(() => {
      /*
       * WHY finalize IS THE CORRECT PLACE:
       * The `finalize` RxJS operator executes its callback when the observable completes or errors.
       * This ensures the loading indicator is always hidden once the HTTP request resolves, 
       * mirroring a try/catch/finally block.
       */
      loadingService.hide();
    })
  );
};
