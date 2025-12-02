import {Component} from '@angular/core';
import {NgClass, NgForOf} from '@angular/common';

@Component({
  selector: 'app-ticket-viewer',
  imports: [NgClass, NgForOf],
  templateUrl: './ticket-viewer.html',
  styleUrl: './ticket-viewer.css',
})
export class TicketViewer {
  protected activeFilter: string = "";
  protected filteredTickets: any[] = [];

  protected setFilter(all: string) {

  }
}
