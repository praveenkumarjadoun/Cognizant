import { CanDeactivateFn } from '@angular/router';
import { ReactiveEnrollmentForm } from '../features/enrollment/components/reactive-enrollment-form/reactive-enrollment-form';

export const unsavedChangesGuard: CanDeactivateFn<ReactiveEnrollmentForm> = (component) => {
  if (component.enrollForm && component.enrollForm.dirty && !component.submitted) {
    return window.confirm('You have unsaved changes. Leave?');
  }
  return true;
};
