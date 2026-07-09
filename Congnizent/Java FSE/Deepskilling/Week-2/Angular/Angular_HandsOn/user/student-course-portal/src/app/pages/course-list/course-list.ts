import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, ActivatedRoute } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';
import { Store } from '@ngrx/store';
import { CourseCard } from '../../components/course-card/course-card';
import { Course } from '../../models/course.model';
import * as CourseActions from '../../store/course/course.actions';
import { selectAllCourses, selectCoursesLoading, selectCoursesError } from '../../store/course/course.selectors';

@Component({
  selector: 'app-course-list',
  imports: [CommonModule, FormsModule, CourseCard],
  templateUrl: './course-list.html',
  styleUrl: './course-list.css',
})
export class CourseList implements OnInit {
  courses$!: Observable<Course[]>;
  isLoading$!: Observable<boolean>;
  errorMessage$!: Observable<string | null>;
  selectedCourseId: number | null = null;
  searchTerm = '';

  constructor(
    private store: Store, 
    private router: Router,
    private route: ActivatedRoute
  ) {
    this.isLoading$ = this.store.select(selectCoursesLoading);
    this.errorMessage$ = this.store.select(selectCoursesError);
  }

  ngOnInit(): void {
    // Dispatch load action on initialize
    this.store.dispatch(CourseActions.loadCourses());

    // Read query parameter on load
    const searchParam = this.route.snapshot.queryParamMap.get('search');
    this.searchTerm = searchParam || '';

    this.filterCourses();
  }

  filterCourses(): void {
    const rawCourses$ = this.store.select(selectAllCourses);
    if (this.searchTerm) {
      this.courses$ = rawCourses$.pipe(
        map(courses => courses.filter(c => 
          c.name.toLowerCase().includes(this.searchTerm.toLowerCase()) ||
          c.code.toLowerCase().includes(this.searchTerm.toLowerCase())
        ))
      );
    } else {
      this.courses$ = rawCourses$;
    }
  }

  onSearchChange(): void {
    this.router.navigate(['/courses'], {
      queryParams: { search: this.searchTerm || null },
      queryParamsHandling: 'merge'
    });
    this.filterCourses();
  }

  onEnroll(courseId: number): void {
    console.log('Enrolling in course: ' + courseId);
    this.selectedCourseId = courseId;
  }

  navigateToCourse(courseId: number): void {
    this.router.navigate(['/courses', courseId]);
  }

  /*
   * PERFORMANCE BENEFIT OF trackBy:
   * By default, Angular re-renders the entire DOM list upon any array change.
   * With trackBy, Angular identifies each item uniquely by its ID. It only updates,
   * adds, or removes the specific item's DOM element that changed, which significantly
   * boosts rendering performance in long lists.
   */
  trackByCourseId(index: number, course: Course): number {
    return course.id;
  }
}
