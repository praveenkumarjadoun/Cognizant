import { ComponentFixture, TestBed } from '@angular/core/testing';
import { ReactiveFormsModule } from '@angular/forms';
import { ReactiveEnrollmentForm } from './reactive-enrollment-form';

describe('ReactiveEnrollmentForm', () => {
  let component: ReactiveEnrollmentForm;
  let fixture: ComponentFixture<ReactiveEnrollmentForm>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ReactiveEnrollmentForm],
      imports: [ReactiveFormsModule]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ReactiveEnrollmentForm);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
