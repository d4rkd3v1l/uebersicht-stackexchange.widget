# copyright d4Rk

command: 'stackexchange.widget/commands.sh'
refreshFrequency: 300000

update: (output, domEl) ->
  # console.log output
  data = JSON.parse(output)
  $domEl = $(domEl)
  $domEl.html("")

  # ME
  me = data.me.items[0];
  $domEl.append("<div><span class='name'>me</span> <a href='#{me.link}'>#{me.display_name}</a></div>")
  $domEl.append("<div><span class='name'>reputation</span> #{me.reputation} (d:#{me.reputation_change_day}, w:#{me.reputation_change_week}, m:#{me.reputation_change_month}, q:#{me.reputation_change_quarter}, y:#{me.reputation_change_year})</div>")
  $domEl.append("<div><span class='name'>posts</span> q:#{me.question_count}, a:#{me.answer_count}</div>")
  $domEl.append("<div><span class='name'>badges</span> g:#{me.badge_counts.gold}, s:#{me.badge_counts.silver}, b:#{me.badge_counts.bronze}</div>")

  # LAST BADGE
  lastBadge = data.lastBadge.items[0]
  $domEl.append("<div><span class='name'>last badge</span> <a href='#{lastBadge.link}'>#{lastBadge.name.toLowerCase()} (#{lastBadge.rank.substring(0, 1)})</a></div>")

  # REPUTATION
  reputationItems = data.reputation.items.slice(0, 3)
  $domEl.append("<table><tr class='item'><th colspan='5'>reputation history</th></tr>")

  for item in reputationItems
    $domEl.append @renderItem(item)

  $domEl.append("</table>")

renderItem: (item) ->
  # date
  date = new Date(item.on_date * 1000)

  # title
  title = item.title.substring(0, 20) + "...";

  # reputation change
  reputationChange = item.reputation_change;
  if item.reputation_change > 0 
    reputationChange = "+".concat(reputationChange)

  if item.reputation_change < 0 
    reputationChange = "-".concat(reputationChange)

  """
    <tr class='entry item'>
      <td width='50'>#{date.getDate()}.#{date.getMonth()}.</td>
      <td width='150'>#{item.vote_type}</td>
      <td width='25'>#{item.post_type.substring(0, 1)}:</td>
      <td width='250'><a href='#{item.link}'>#{title.toLowerCase()}</a></td>
      <td width='25' class='right'>#{reputationChange}</td>
    </tr>
  """

style: """
  right 0%
  bottom 0%
  padding 0
  margin 0
  color #ccc
  font-family Menlo
  font-size 1em
  width 500px
  background-color rgba(0, 0, 0, 0.5) 

  span.name, th
    font-weight bold
    color lime

  .left
    text-align left

  .right 
    text-align right

  .item
    text-align left

  a
    text-decoration none
    color #ccc
"""