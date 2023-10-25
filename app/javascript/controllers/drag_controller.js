import { Controller } from "@hotwired/stimulus"
import { post } from "@rails/request.js";

// Connects to data-controller="drag"
export default class extends Controller {

  dragstart(event) {
    event.target.classList.add("dragging");
    const board = event.target.parentElement
    const boardId = board.dataset.boardId;

    if(board.children.length == 1) {
      this.addNoCard(board, boardId);
    }
  }

  dragend(event) {
    event.currentTarget.classList.remove("dragging");
  }

  dragover(event) {
    event.preventDefault();
  }


  ulEnter(event) {
    event.preventDefault();
    const boardId = event.currentTarget.dataset.boardId;
    this.removeNoCard(boardId);
  }

  ulLeave(event) {
    event.preventDefault();
    const board = event.currentTarget;
    const boardId = board.dataset.boardId;

    if(board.children.length == 1) {
     this.addNoCard(board, boardId);
    }
  }

  ulOver(event) {
    event.preventDefault();
    const board = event.currentTarget;
    const boardId = board.dataset.boardId;

    const afterElement = this.getDragAfterElement(board, event.clientY);
    const draggable = document.querySelector(".dragging");

    if (afterElement == null) {
      board.appendChild(draggable);
    } else {
      board.insertBefore(draggable, afterElement);
    }

    this.removeNoCard(boardId);
  }

  ulEnd(event) {
    event.preventDefault();
    const draggable = event.target
    const { workspaceId, boardId } = event.currentTarget.dataset;
    const cardId = draggable.dataset.cardId;

    this.moveCard(workspaceId, boardId, cardId);
  }

  getDragAfterElement(column, y) {
    const draggableElements = [
      ...column.querySelectorAll(".list-group-item:not(.dragging)"),
    ];

    return draggableElements.reduce(
      (closest, child) => {
        const box = child.getBoundingClientRect();
        const offset = y - box.top - box.height / 2;
        if (offset < 0 && offset > closest.offset) {
          return { offset: offset, element: child };
        } else {
          return closest;
        }
      },
      { offset: Number.NEGATIVE_INFINITY }
    ).element;
  }

  removeNoCard(boardId) {
    const noCard = document.getElementById(`board_${boardId}_no_cards`);
    if(noCard) {
      noCard.remove();
    }
  }

  addNoCard(board, boardId) {
    const empty = document.createElement("li");
    empty.classList.add("list-group-item");
    empty.id = `board_${boardId}_no_cards`;
    empty.textContent = "No cards yet.";
    board.appendChild(empty);
  }

  moveCard(workspaceId, boardId, cardId) {
    const url = `/workspaces/${workspaceId}/boards/${boardId}/cards/move`;
    const data = new FormData();
    data.append("card_id", cardId);

    // Send a POST request in format Turbo Stream
    post(url, {
      body: data,
      credentials: "same-origin",
      headers: {
        Accept: "text/vnd.turbo-stream.html",
        Origin: "same-origin"
      },
    });
  }
}
