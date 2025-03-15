# FetchRecipes

### Summary: Include screen shots or a video of your app highlighting its features
![Simulator Screenshot - iPhone 16 Pro - 2025-03-14 at 21 22 15](https://github.com/user-attachments/assets/af3aeb57-2647-47c8-a3cb-8d92a3a7e0ba)
![Simulator Screenshot - iPhone 16 Pro - 2025-03-14 at 21 21 44](https://github.com/user-attachments/assets/8610fb47-5269-4e12-bb70-f0195fcbf315)

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

I would say implementing caching. I've maybe implemented this myself once without using external dependencies so this took me a bit of time to figure out. I also realized towards the end that the description said cache to "disk". I believe my implementation caches to both from what I understand, but if we only wanted to cache to disk, I think I need to explicitly state that. 

I also prioritozed my time on dependency injection and testability. That is why I created the service protocol and the viewModel. 

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

I would say I spent a total of 4 hours on this project. Didn't want to go any longer than that based on the requirements and with it being a take home test, I felt it should be no longer than that. I started with the model, then worked on constructing the network call to fetch recipes, then on to the UI, worked on caching, and lastly testing. Saved the hardest/most time consuming parts for last.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

Yes, I created that AsyncCachedImage view which includes a downloadPhoto function inside the view itself, which made it hard to test caching. 

### Weakest Part of the Project: What do you think is the weakest part of your project?

The caching part of the project. Like I mentioned above. I haven't implemented that very much. I've usually used a 3rd party library for that or it's already been implemented in the project.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

Like I mentioned above, caching was the hardest thing for me. I feel like I accomplished it, but I did it in such a way that made it hard to test the caching functionality. If I had more time, I would have probably came up with a different solution for caching that would make testing it easier. Another thing I would've focused on is the UI and making it nicer. Overall, I felt pretty confident with the project.
