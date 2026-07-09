import { ComponentFixture, TestBed } from '@angular/core/testing';
import { By } from '@angular/platform-browser';
import { ActivatedRoute, convertToParamMap } from '@angular/router';
import { provideMockStore, MockStore } from '@ngrx/store/testing';
import { CourseList } from './course-list';
import { Course } from '../../models/course.model';

describe('CourseList', () => {
  let component: CourseList;
  let fixture: ComponentFixture<CourseList>;
  let store: MockStore;

  const mockCourses: Course[] = [
    { id: 1, name: 'Web Dev', code: 'CS101', credits: 4, gradeStatus: 'passed' },
    { id: 2, name: 'Advanced Java', code: 'CS102', credits: 3, gradeStatus: 'pending' }
  ];

  const initialState = {
    course: {
      courses: mockCourses,
      loading: false,
      error: null
    },
    enrollment: {
      enrolledCourseIds: []
    }
  };

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [CourseList],
      providers: [
        provideMockStore({ initialState }),
        {
          provide: ActivatedRoute,
          useValue: {
            snapshot: {
              queryParamMap: convertToParamMap({ search: '' })
            }
          }
        }
      ]
    }).compileComponents();

    fixture = TestBed.createComponent(CourseList);
    component = fixture.componentInstance;
    store = TestBed.inject(MockStore);
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should render course cards matching the initial state', () => {
    fixture.detectChanges();
    const cardElements = fixture.debugElement.queryAll(By.css('app-course-card'));
    expect(cardElements.length).toBe(2);
  });

  it('should show loading indicator when loading is true', () => {
    store.setState({
      course: {
        courses: [],
        loading: true,
        error: null
      },
      enrollment: {
        enrolledCourseIds: []
      }
    });
    
    fixture.detectChanges();
    
    // Check loading indicator visibility
    const loadingEl = fixture.debugElement.query(By.css('.loading-state'));
    expect(loadingEl).toBeTruthy();
    
    const cardElements = fixture.debugElement.queryAll(By.css('app-course-card'));
    expect(cardElements.length).toBe(0);
  });
});
