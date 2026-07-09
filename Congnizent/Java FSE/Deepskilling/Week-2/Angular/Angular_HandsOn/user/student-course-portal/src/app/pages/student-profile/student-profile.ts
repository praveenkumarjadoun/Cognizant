import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Observable } from 'rxjs';
import { Store } from '@ngrx/store';
import { Course } from '../../models/course.model';
import { Notification } from '../../components/notification/notification';
import * as EnrollmentActions from '../../store/enrollment/enrollment.actions';
import * as CourseActions from '../../store/course/course.actions';
import { selectEnrolledCourses } from '../../store/enrollment/enrollment.selectors';

@Component({
  selector: 'app-student-profile',
  imports: [CommonModule, Notification],
  templateUrl: './student-profile.html',
  styleUrl: './student-profile.css',
})
export class StudentProfile implements OnInit {
  enrolledCourses$: Observable<Course[]>;
  studentName = 'Alex Mercer';
  studentEmail = 'alex.mercer@college.edu';
  studentGpa = 3.8;

  constructor(private store: Store) {
    this.enrolledCourses$ = this.store.select(selectEnrolledCourses);
  }

  ngOnInit(): void {
    // Ensure courses list is loaded in store so cross-slice selector maps details successfully
    this.store.dispatch(CourseActions.loadCourses());
  }

  unenroll(courseId: number): void {
    this.store.dispatch(EnrollmentActions.unenrollFromCourse({ courseId }));
  }
}
