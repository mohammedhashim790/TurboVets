import { TestBed } from '@angular/core/testing';

import { KBEService } from './kbeservice';

describe('KBEService', () => {
  let service: KBEService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(KBEService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
