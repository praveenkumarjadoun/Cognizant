import { ComponentFixture, TestBed } from '@angular/core/testing';
import { FormsModule } from '@angular/forms';
import { EnrollmentForm } from './enrollment-form';

describe('EnrollmentForm', () => {
  let component: EnrollmentForm;
  let fixture: ComponentFixture<EnrollmentForm>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [EnrollmentForm],
      imports: [FormsModule]
    })
    .compileComponents();

    fixture = TestBed.createComponent(EnrollmentForm);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
