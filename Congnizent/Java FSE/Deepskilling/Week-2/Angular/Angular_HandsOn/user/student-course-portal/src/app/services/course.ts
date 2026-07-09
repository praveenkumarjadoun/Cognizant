import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { map, catchError, tap, retry } from 'rxjs/operators';
import { Course } from '../models/course.model';

@Injectable({
  providedIn: 'root',
})
export class CourseService {
  private apiUrl = 'http://localhost:3000/courses';

  constructor(private http: HttpClient) {}

  getCourses(): Observable<Course[]> {
    return this.http.get<Course[]>(this.apiUrl).pipe(
      // Step 86: Retry failed requests up to 2 times before propagating error
      retry(2),
      // Step 83: Filter courses with credits > 0
      map(courses => courses.filter(c => c.credits > 0)),
      // Step 85: Side effect logging
      /*
       * WHY `tap` IS PREFERRED OVER SIDE EFFECTS INSIDE `map`:
       * `tap` is designed exclusively for side effects (e.g. logging, spy-checking, updating load UI)
       * without altering the stream value or type.
       * `map` is purely for transforming/modifying the value itself. Keep them separated.
       */
      tap(courses => console.log('Courses loaded via HTTP:', courses.length)),
      // Step 84: Catching and throwing formatted errors
      catchError(err => {
        console.error('HTTP Error in getCourses:', err);
        return throwError(() => new Error('Failed to load courses. Please try again.'));
      })
    );
  }

  getCourseById(id: number): Observable<Course> {
    return this.http.get<Course>(`${this.apiUrl}/${id}`).pipe(
      catchError(err => {
        console.error(`HTTP Error in getCourseById (${id}):`, err);
        return throwError(() => new Error(`Failed to load course details for ID ${id}.`));
      })
    );
  }

  createCourse(course: Omit<Course, 'id'>): Observable<Course> {
    return this.http.post<Course>(this.apiUrl, course);
  }

  updateCourse(id: number, course: Course): Observable<Course> {
    return this.http.put<Course>(`${this.apiUrl}/${id}`, course);
  }

  deleteCourse(id: number): Observable<any> {
    return this.http.delete<any>(`${this.apiUrl}/${id}`);
  }
}
