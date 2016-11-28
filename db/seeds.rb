#Contest.create!([
#  {title: "Mega Contest", contest_type: "mega", banner: "Photo-contest.png", description: "Branding Photoshoot Contest", steps: "Upload your best clicks here and share it on your FB page, whoever gets most no of likes, wins the prize<ul><li style=\"disc;\">Log in or SignUp with Facebook</li><li style=\"disc;\">Upload your best pictures</li><li>Share on your wall, share with your friends and keep sharing</li></ul>", first_prize: "Trip to Thailand", second_prize: "Trip to Nagaland", third_prize: "Trip to bagal wala land", status: "active", suspension_reason: "", start_date: "2016-11-19 11:33:00", end_date: "2016-11-22 11:33:00"},
#  {title: "Monthly Contest", contest_type: "monthly", banner: "Photo-contest.png", description: "Branding Photoshoot", steps: "Login to FB...", first_prize: "Trip to Wadala", second_prize: "", third_prize: "", status: "active", suspension_reason: "", start_date: "2016-11-21 21:52:00", end_date: "2016-11-30 23:52:00"},
#  {title: "Weekly Contest", contest_type: "weekly", banner: "Photo-contest.png", description: "Branding Photoshoot", steps: "Login through FB", first_prize: "Trip to Thailand", second_prize: "", third_prize: "", status: "active", suspension_reason: "", start_date: "2016-11-25 11:53:00", end_date: "2016-11-30 11:53:00"}
# )
Entry.create!([
  {contest_id: 1, uploaded_image: "testentry.png", uploaded_video: "", caption: "Amazing view", mobile: "9375560075", email: "ravi@test.com", votes: nil, shares: nil, status: nil, rejected_reason: nil},
  {contest_id: 1, uploaded_image: "testentry.png", uploaded_video: "", caption: "Amazing view from maldives", mobile: "9375560075", email: "hemant_14j83@yahoo.co.in", votes: nil, shares: nil, status: nil, rejected_reason: nil},
  {contest_id: 1, uploaded_image: "testentry.png", uploaded_video: "", caption: "Amazing view from maldives Most Amazing", mobile: "7845784578", email: "sffskfjhskjf@test.com", votes: nil, shares: nil, status: nil, rejected_reason: nil}
])
