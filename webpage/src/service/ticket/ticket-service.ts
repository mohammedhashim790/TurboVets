import {Injectable} from '@angular/core';
import {IService} from '../IService';
import {Ticket, TicketStatus} from '../../models/ticket.model';

@Injectable({
  providedIn: 'root',
})
export class TicketService implements IService<Ticket> {


  _templates: Ticket[] = [{
    id: 0, subject: "Subject 1", status: TicketStatus.OPEN, createdAt: new Date(), updatedAt: new Date()
  }, {
    id: 1, subject: "Subject 2", status: TicketStatus.OPEN, createdAt: new Date(), updatedAt: new Date()
  }, {
    id: 2, subject: "Subject 3", status: TicketStatus.CLOSED, createdAt: new Date(), updatedAt: new Date()
  }, {
    id: 3, subject: "Subject 4", status: TicketStatus.CLOSED, createdAt: new Date(), updatedAt: new Date()
  }, {
    id: 4, subject: "Subject 5", status: TicketStatus.IN_PROGRESS, createdAt: new Date(), updatedAt: new Date()
  }, {
    id: 5, subject: "Subject 6", status: TicketStatus.IN_PROGRESS, createdAt: new Date(), updatedAt: new Date()
  }, {
    id: 6, subject: "Subject 7", status: TicketStatus.OPEN, createdAt: new Date(), updatedAt: new Date()
  }];


  constructor() {
  }

  list(): Promise<Ticket[]> {
    return Promise.resolve(this._templates);
  }

  getById(id: number): Promise<Ticket[]> {
    return Promise.resolve(this._templates.filter(item => item.id === id));
  }

  create(item: Ticket): Promise<Ticket> {
    this._templates.push(item);

    return Promise.resolve(item);
  }

  delete(id: number): Promise<Ticket> {
    throw new Error("Method not implemented.");
  }

  update(item: Ticket): Promise<Ticket> {
    throw new Error("Method not implemented.");
  }


  getByStatus(status: TicketStatus): Promise<Ticket[]> {
    return Promise.resolve(this._templates.filter(item => item.status === status));
  }
}
