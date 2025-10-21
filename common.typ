
/* Internal Utilities */

/* This is the logical page */
#let current_page() = counter(page).at(here()).first()

#let current_physical_page() = here().position().page