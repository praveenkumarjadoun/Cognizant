import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, FormArray, FormControl, Validators, AbstractControl, ValidationErrors } from '@angular/forms';

// Custom Synchronous Validator
export function noCourseCode(control: AbstractControl): ValidationErrors | null {
  const value = String(control.value || '');
  if (value.startsWith('XX')) {
    return { noCourseCode: true };
  }
  return null;
}

// Custom Asynchronous Validator
export function simulateEmailCheck(control: AbstractControl): Promise<ValidationErrors | null> {
  return new Promise((resolve) => {
    setTimeout(() => {
      const email = String(control.value || '');
      if (email.includes('test@')) {
        resolve({ emailTaken: true });
      } else {
        resolve(null);
      }
    }, 800);
  });
}

@Component({
  selector: 'app-reactive-enrollment-form',
  standalone: false,
  templateUrl: './reactive-enrollment-form.html',
  styleUrl: './reactive-enrollment-form.css',
})
export class ReactiveEnrollmentForm implements OnInit {
  enrollForm!: FormGroup;
  submitted = false;

  constructor(private fb: FormBuilder) {}

  ngOnInit(): void {
    this.enrollForm = this.fb.group({
      studentName: ['', [Validators.required, Validators.minLength(3)]],
      studentEmail: ['', [Validators.required, Validators.email], [simulateEmailCheck]],
      courseId: ['', [Validators.required, noCourseCode]],
      preferredSemester: ['Odd', Validators.required],
      agreeToTerms: [false, Validators.requiredTrue],
      additionalCourses: this.fb.array([])
    });
  }

  // Typed getter for FormArray
  /*
   * WHY A TYPED GETTER IS BETTER THAN CASTING IN TEMPLATE:
   * 1. TypeScript casting like `as FormArray` is not syntactically valid in HTML templates.
   * 2. It keeps the template clean and readable, keeping complex logic inside the TS class.
   * 3. It provides full IDE IntelliSense, autocomplete, type checking, and easier refactoring.
   */
  get additionalCourses(): FormArray {
    return this.enrollForm.get('additionalCourses') as FormArray;
  }

  addCourse(): void {
    this.additionalCourses.push(this.fb.control('', Validators.required));
  }

  removeCourse(index: number): void {
    this.additionalCourses.removeAt(index);
  }

  onSubmit(): void {
    if (this.enrollForm.valid) {
      this.submitted = true;
      
      /*
       * DIFFERENCE BETWEEN enrollForm.value AND enrollForm.getRawValue():
       * 
       * enrollForm.value:
       * Excludes values of any form controls that are currently disabled.
       *
       * enrollForm.getRawValue():
       * Returns values of all controls inside the group, regardless of their disabled status.
       * Use getRawValue() when you need to send the full, complete set of data to the server.
       */
      console.log('Reactive Form Value:', this.enrollForm.value);
      console.log('Reactive Form Raw Value:', this.enrollForm.getRawValue());
      console.log('Reactive Form Validity:', this.enrollForm.valid);
    }
  }

  resetForm(): void {
    this.enrollForm.reset({
      preferredSemester: 'Odd',
      agreeToTerms: false
    });
    this.additionalCourses.clear();
    this.submitted = false;
  }
}
