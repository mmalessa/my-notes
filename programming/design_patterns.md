# Design patterns

## Creational
| Nazwa | Idea + użycie |
|--------|----------------|
| **Singleton** | **Idea:** tylko jedna instancja klasy.  <br> **Użycie:** zasoby globalne (konfiguracja, logger) — ale uważaj, bo trudny do testowania. |
| **Factory Method** | **Idea:** delegujesz tworzenie obiektów do podklas/metody fabrycznej.  <br> **Użycie:** gdy klient nie powinien znać konkretnej klasy. |
| **Abstract Factory** | **Idea:** rodzina powiązanych fabryk.  <br> **Użycie:** gdy trzeba tworzyć zestawy spójnych obiektów. |
| **Builder** | **Idea:** stopniowe budowanie złożonego obiektu (metoda fluent).  <br> **Użycie:** budowanie obiektów ze skomplikowaną konfiguracją. |
| **Prototype** | **Idea:** kopiowanie istniejącego obiektu (clone) zamiast tworzenia od zera.  <br> **Użycie:** gdy tworzenie obiektu jest kosztowne. |


## Structural
| Nazwa | Idea + użycie |
|--------|----------------|
| **Adapter** | **Idea:** dopasowuje interfejs klasy do oczekiwanego interfejsu klienta.  <br> **Użycie:** integracja starych bibliotek. |
| **Facade** | **Idea:** upraszcza skomplikowany subsystem udostępniając prosty interfejs.  <br> **Użycie:** API wyższego poziomu. |
| **Decorator** | **Idea:** dynamicznie dodaje zachowania do obiektów bez dziedziczenia.  <br> **Użycie:** rozszerzanie funkcjonalności obiektów w runtime. |
| **Proxy** | **Idea:** zastępuje rzeczywisty obiekt i kontroluje do niego dostęp (np. lazy loading, remote proxy).  <br> **Użycie:** bezpieczeństwo, caching, lazy init. |
| **Composite** | **Idea:** traktuj strukturę drzewa (liść i kompozyt) jednakowo.  <br> **Użycie:** struktury drzewa, menu, XML/DOM. |


# Behavioral
| Nazwa | Idea + użycie |
|--------|----------------|
| **Strategy** | **Idea:** enkapsuluj algorytmy jako wymienne klasy.  <br> **Użycie:** zmiana zachowania w runtime. |
| **Observer** | **Idea:** subskrybenci są powiadamiani o zmianach stanu wydawcy.  <br> **Użycie:** zdarzenia, systemy notyfikacji. |
| **Command** | **Idea:** kapsułkuj polecenie jako obiekt — undo, kolejkowanie, remote call.  <br> **Użycie:** kolejki zadań, undo/redo. |
| **Template Method** | **Idea:** szkielet algorytmu w metodzie abstrakcyjnej, kroki częściowo implementowane w podklasach.  <br> **Użycie:** kiedy pewne kroki algorytmu są stałe, inne zmienne. |
| **State** | **Idea:** obiekt zmienia zachowanie gdy zmienia swój stan — stan reprezentowany przez obiekty.  <br> **Użycie:** maszyny stanów, workflow. |
