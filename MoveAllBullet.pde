void moveAllBullets()
{
  for(Bullet temp : bullets)
  {
    temp.move();
  }
}

void displayAllBullets()
{
  for(Bullet temp : bullets)
  {
    temp.display();
  }
}

void removeToBulletLimit(int maxLength)
{
  while(bullets.size() > maxLength)
  {
    bullets.remove(0);
  }
  for(Bullet b : bullets)
  {
    if(b.y <= 0)
    {
      bullets.remove(b); 
      break; 
    }
  }
}