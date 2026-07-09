import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, forkJoin, of } from 'rxjs';
import { map, switchMap, tap } from 'rxjs/operators';
import { Course } from '../models/course.model';
import { CourseService } from './course';

@Injectable({
  providedIn: 'root',
})
export class EnrollmentService {
  private apiUrl = 'http://localhost:3000/enrollments';
  private enrolledCourseIds: number[] = [1, 3, 5];

  constructor(private http: HttpClient, private courseService: CourseService) {
    this.syncInitialEnrollments();
  }

  private syncInitialEnrollments(): void {
    this.http.get<any[]>(`${this.apiUrl}?studentId=1`).subscribe(records => {
      if (records) {
        this.enrolledCourseIds = records.map(r => Number(r.courseId));
      }
    });
  }

  enroll(courseId: number): void {
    if (!this.enrolledCourseIds.includes(courseId)) {
      this.enrolledCourseIds.push(courseId);
      this.http.post(this.apiUrl, { studentId: 1, courseId }).subscribe();
    }
  }

  unenroll(courseId: number): void {
    this.enrolledCourseIds = this.enrolledCourseIds.filter(id => id !== courseId);
    this.http.get<any[]>(`${this.apiUrl}?courseId=${courseId}&studentId=1`).subscribe(records => {
      if (records && records.length > 0) {
        records.forEach(r => {
          this.http.delete(`${this.apiUrl}/${r.id}`).subscribe();
        });
      }
    });
  }

  isEnrolled(courseId: number): boolean {
    return this.enrolledCourseIds.includes(courseId);
  }

  getEnrolledCourseIds(): number[] {
    return this.enrolledCourseIds;
  }

  getEnrolledCourses(): Observable<Course[]> {
    return this.http.get<any[]>(`${this.apiUrl}?studentId=1`).pipe(
      switchMap(records => {
        const courseIds = records.map(r => Number(r.courseId));
        if (courseIds.length === 0) {
          return of([]);
        }
        const obsArray = courseIds.map(id => this.courseService.getCourseById(id));
        return forkJoin(obsArray);
      })
    );
  }

  // Step 87: switchMap student fetch
  /*
   * WHY switchMap CANCELS PREVIOUS INNER OBSERVABLE:
   * When a new course ID parameter is emitted, `switchMap` immediately cancels the previous
   * HTTP request if it is still pending/in-flight, and switches to the new inner observable request.
   * This ensures that responses never arrive out-of-order, eliminating race conditions.
   */
  getStudentsByCourse(courseId: number): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}?courseId=${courseId}`).pipe(
      map(enrollments => enrollments.map(e => e.studentId))
    );
  }
}
