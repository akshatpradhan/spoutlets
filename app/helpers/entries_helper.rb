module EntriesHelper

 def width_for(emotional_state)
   emotional_state.to_i * 20
 end

 def like_status_for(entry, user)
   return "Nobody knows the feeling." if entry.likes == 0
   out = []
   if entry.liked? user
     out << "You"
     out << "and" if entry.likes > 1
     out << "<b>#{entry.likes - 1}</b> others" if entry.likes > 1
   else
     out << "<b>#{entry.likes}</b> others" if entry.likes > 1
   end
   out << "know the feeling."
   out.join(" ").html_safe
 end
end
