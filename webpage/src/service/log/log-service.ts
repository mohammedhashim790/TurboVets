import {Injectable} from '@angular/core';
import {IService} from '../IService';
import {Log, LogLevel} from '../../models/log';
import {BehaviorSubject, interval, Observable, Subscription} from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class LogService implements IService<Log> {
  _template: Log[] = [{
    id: "1", message: "Application started successfully.", level: LogLevel.INFO, timestamp: Date.now() - 10000
  }, {
    id: "2", message: "Fetching initial ticket list...", level: LogLevel.INFO, timestamp: Date.now() - 9000
  }, {
    id: "3", message: "Ticket list fetched (12 items).", level: LogLevel.INFO, timestamp: Date.now() - 8200
  }, {
    id: "4", message: "User clicked filter: OPEN", level: LogLevel.INFO, timestamp: Date.now() - 7300
  }, {
    id: "5", message: "API Request: GET /tickets?status=OPEN", level: LogLevel.INFO, timestamp: Date.now() - 6500
  }, {
    id: "6", message: "API Response: 200 OK (5 open tickets)", level: LogLevel.INFO, timestamp: Date.now() - 5800
  }, {
    id: "7", message: "WebSocket connected to live-log service.", level: LogLevel.INFO, timestamp: Date.now() - 5000
  }, {
    id: "8",
    message: "Live event received: New ticket created (#1082).",
    level: LogLevel.INFO,
    timestamp: Date.now() - 4200
  }, {
    id: "9",
    message: "Warning: Slow response detected on /tickets endpoint.",
    level: LogLevel.WARN,
    timestamp: Date.now() - 3300
  }, {
    id: "10",
    message: "Error: Failed to load user profile. Retrying...",
    level: LogLevel.ERROR,
    timestamp: Date.now() - 2500
  }];


  private logger: BehaviorSubject<Log | undefined> = new BehaviorSubject<Log | undefined>(undefined);
  private streamer?: Subscription;

  list(): Promise<Log[]> {
    return Promise.resolve(this._template);
  }


  openStream(): Observable<Log | undefined> {
    this.streamer = interval(2000).subscribe(log => {
      const id = (this._template.length + 1).toString();
      const level = LogLevel.INFO;
      this.logger.next({id: id, level: level, message: `This a sample Log ${id}`, timestamp: Date.now()})
    });
    return this.logger.asObservable();
  }

  closeStream(): void {
    this.streamer?.unsubscribe();
  }


  getById(id: number): Promise<Log[]> {
    throw new Error("Method not implemented.");
  }

  create(item: Log): Promise<Log> {
    this._template.push(item);
    return Promise.resolve(item);
  }

  delete(id: number): Promise<Log> {
    throw new Error("Method not implemented.");
  }

  update(item: Log): Promise<Log> {
    throw new Error("Method not implemented.");
  }


}
