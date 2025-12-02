import {Component, OnInit} from '@angular/core';
import {NgClass} from '@angular/common';
import {Ticket, TicketStatus} from '../../models/ticket.model';
import {TicketService} from '../../service/ticket/ticket-service';

@Component({
  selector: 'ticket-viewer', imports: [NgClass], templateUrl: './ticket-viewer.html', styleUrl: './ticket-viewer.css',
})
export class TicketViewer implements OnInit {
  protected activeFilter: "ALL" | TicketStatus = "ALL";

  public filteredTickets: Ticket[] = [];

  constructor(protected ticketService: TicketService) {
    this.setFilter("ALL");
  }


  ngOnInit(): void {
  }


  protected async setFilter(status: "ALL" | TicketStatus): Promise<void> {
    this.activeFilter = status;

    if (status === "ALL") {
      this.filteredTickets = await this.ticketService.list();
    } else {
      this.filteredTickets = await this.ticketService.getByStatus(status);
    }
  }

  protected readonly TicketStatus = TicketStatus;
}
