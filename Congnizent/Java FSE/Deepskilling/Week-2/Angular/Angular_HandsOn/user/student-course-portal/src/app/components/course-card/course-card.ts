import { Component, Input, Output, EventEmitter, OnChanges, SimpleChanges, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Observable } from 'rxjs';
import { Store } from '@ngrx/store';
import { Course } from '../../models/course.model';
import { CreditLabelPipe } from '../../pipes/credit-label-pipe';
import { Highlight } from '../../directives/highlight';
import * as EnrollmentActions from '../../store/enrollment/enrollment.actions';
import { selectEnrolledIds } from '../../store/enrollment/enrollment.selectors';

@Component({
  selector: 'app-course-card',
  imports: [CommonModule, CreditLabelPipe, Highlight],
  templateUrl: './course-card.html',
  styleUrl: './course-card.css',
})
export class CourseCard implements OnChanges, OnInit {
  @Input() course!: Course;
  @Output() enrollRequested = new EventEmitter<number>();

  isExpanded = false;
  enrolledIds$: Observable<number[]>;

  constructor(private store: Store) {
    this.enrolledIds$ = this.store.select(selectEnrolledIds);
  }

  ngOnInit(): void {}

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['course']) {
      const prev = changes['course'].previousValue;
      const curr = changes['course'].currentValue;
      console.log(`Course card ngOnChanges triggered for course ${this.course?.code}:`, {
        previous: prev,
        current: curr
      });
    }
  }

  toggleDetails(): void {
    this.isExpanded = !this.isExpanded;
  }

  toggleEnroll(isCurrentlyEnrolled: boolean): void {
    if (!this.course) return;
    if (isCurrentlyEnrolled) {
      this.store.dispatch(EnrollmentActions.unenrollFromCourse({ courseId: this.course.id }));
    } else {
      this.store.dispatch(EnrollmentActions.enrollInCourse({ courseId: this.course.id }));
      this.enrollRequested.emit(this.course.id);
    }
  }
}
