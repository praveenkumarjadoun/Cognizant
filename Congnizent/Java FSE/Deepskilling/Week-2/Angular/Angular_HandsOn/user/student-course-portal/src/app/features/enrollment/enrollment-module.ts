import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { EnrollmentRoutingModule } from './enrollment-routing-module';
import { EnrollmentForm } from './components/enrollment-form/enrollment-form';
import { ReactiveEnrollmentForm } from './components/reactive-enrollment-form/reactive-enrollment-form';


@NgModule({
  declarations: [
    EnrollmentForm,
    ReactiveEnrollmentForm
  ],
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    EnrollmentRoutingModule
  ]
})
export class EnrollmentModule { }
