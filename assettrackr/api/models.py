from django.db import models
from django.contrib.auth.models import User

class Assets(models.Model):
    ASSET_TYPE_CHOICES = [
        ('equity','equity'),
        ('debt','debt'),
        ('gold','gold'),
        ('real_estate','real_estate')
    ]
    HOLDING_TYPE_CHOICES = [
        ('mutual_fund', 'mutual_fund'),
        ('stock', 'stock'),
        ('etf','etf')
    ]

    id = models.PositiveIntegerField(primary_key=True)
    fetch_name = models.CharField(max_length=500, null=True)
    show_name = models.CharField(max_length=500, null=True)
    asset_type = models.CharField(max_length=20, choices=ASSET_TYPE_CHOICES)
    holding_type = models.CharField(max_length=20, choices=HOLDING_TYPE_CHOICES)
    current_price = models.DecimalField(max_digits=10, decimal_places=5)

    def __str__(self) -> str:
        return f"{self.fetch_name} | {self.holding_type} | {self.asset_type}"

class UserHoldings(models.Model):
    ACTION_CHOICES = [
        ('buy','buy'),
        ('sell','sell')
    ]
    asset = models.ForeignKey(to=Assets, to_field="id", on_delete=models.CASCADE, related_name="held_by")
    user = models.ForeignKey(to=User, on_delete=models.CASCADE, related_name='holdings')
    date = models.DateTimeField(auto_now_add=True)
    quantity = models.PositiveIntegerField()
    action = models.CharField(max_length=5, choices=ACTION_CHOICES)
    price = models.DecimalField(max_digits=50, decimal_places=10)
    class meta:
        unique_together = ['asset','user']

