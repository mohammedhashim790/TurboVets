export enum TicketStatus {
  OPEN, IN_PROGRESS, CLOSED, ALL
}

export type Ticket = {
  id: number; subject: string; status: TicketStatus, createdAt: Date, updatedAt: Date;
}
