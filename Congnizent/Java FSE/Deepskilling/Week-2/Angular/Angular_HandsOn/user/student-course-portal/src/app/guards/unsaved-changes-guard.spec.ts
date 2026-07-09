import { TestBed } from '@angular/core/testing';
import { CanDeactivateFn } from '@angular/router';
import { unsavedChangesGuard } from './unsaved-changes-guard';
import { ReactiveEnrollmentForm } from '../features/enrollment/components/reactive-enrollment-form/reactive-enrollment-form';

describe('unsavedChangesGuard', () => {
  it('should be created', () => {
    expect(unsavedChangesGuard).toBeTruthy();
  });
});
